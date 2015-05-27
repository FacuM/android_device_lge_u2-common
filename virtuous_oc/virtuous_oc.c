/*
  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <fcntl.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <cutils/sockets.h>
#include <android/log.h>

#define CONFIG_FILE "/system/etc/virtuous_oc/virtuous_oc.conf"

#define GOVERNOR "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

#define SYS_WAKE "/sys/power/wait_for_fb_wake"
#define SYS_SLEEP "/sys/power/wait_for_fb_sleep"

#define APPNAME "sleep_governor"

typedef struct s_ocConfig
{
    char wake_governor[30];
    char sleep_governor[30];
} ocConfig;

void my_trim(char *str)
{
    int i;
    for (i = 0; str[i] != 0; i++)
        if ((str[i] == '\n' || str[i] == '\r'))
            str[i] = 0;
}

int write_to_file(char *path, char *value)
{
    FILE *fd;
    int res = 0;

    fd = fopen(path, "w");
    if (fd == NULL)
        return -1;
    if (fputs(value, fd) < 0)
        res = -1;
    fclose(fd);
    return res;
}

int read_from_file(char *path, int len, char *result)
{
    FILE *fd;
    int res = 0;

    fd = fopen(path, "r");
    if (fd == NULL)
        return -1;
    if (fgets(result, len, fd) == NULL)
        res = -1;
    fclose(fd);
    return res;
}

int set_cpu_params(char *governor)
{
    if (write_to_file(GOVERNOR, governor) != 0)
        return -1;

    char buf[255];
    buf[0] = 0;
    strcat(buf, "Setting CPU Params: Governor=");
    my_trim(governor);
    strcat(buf, governor);
    __android_log_write(ANDROID_LOG_INFO, APPNAME, buf);
    return 0;
}

int get_config_value(char *config_key, char *reference)
{
    FILE *config_file;
    config_file = fopen(CONFIG_FILE, "r");

    if (config_file == NULL) {
        __android_log_write(ANDROID_LOG_INFO, APPNAME, "Cannot open configuration file for input.");
        config_file = fopen(CONFIG_FILE, "r");
    }
	
    char line[30];
    char log[40];
    char temp[30];
    int res = -1;
    while (fgets(line, sizeof line, config_file)) {
        if (strncmp(line, config_key, strlen (config_key)) == 0) {
            strcpy(temp, config_key);
            strcat(temp, "%s");

            if (sscanf(line, temp, reference)) {
                strcpy(log, "Found ");
                strcat(log, config_key);
                strcat(log, reference);
                __android_log_write(ANDROID_LOG_INFO, APPNAME, log);
                res = 0;
                break;
            }
        }
    }

    fclose(config_file);

    if (res == -1) {
        strcpy(log, "Could not find ");
        strcat(log, config_key);
        __android_log_write(ANDROID_LOG_INFO, APPNAME, log);
    }
    return res;
}

int load_config(ocConfig *conf)
{
    if (conf == NULL)
        return -1;
    if (get_config_value("wake_governor=", conf->wake_governor) == -1)
        return -1;
    if (get_config_value("sleep_governor=", conf->sleep_governor) == -1)
        return -1;
    return 0;
}

int main(int argc, char **argv)
{
    ocConfig  conf;
    pid_t pid, sid;
    char input_buffer[9];

    __android_log_write(ANDROID_LOG_INFO, APPNAME, "Starting service.");

    if (load_config(&conf) == -1)
    {
        __android_log_write(ANDROID_LOG_ERROR, APPNAME, "Unable to load configuration. Stopping.");
        return 1;
    }

    input_buffer[0] = 0;

    pid = fork();
    if (pid < 0)
        exit(2);
    if (pid > 0)
        exit(0);
    umask(0);

    sid = setsid();
    if (sid < 0)
        exit(2);
    if ((chdir("/")) < 0)
        exit(2);
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    while (1)
    {
        if (read_from_file(SYS_WAKE, 6, input_buffer) == -1)
        {
            __android_log_write(ANDROID_LOG_ERROR, APPNAME, "Unable to get data from file. Cannot continue.");
            return 1;
        }

        if (strcmp(input_buffer, "awake") == 0)
        {
            __android_log_write(ANDROID_LOG_INFO, APPNAME, "Setting awake profile.");
            set_cpu_params(conf.wake_governor);
        }

        input_buffer[0] = '\0';

        if (read_from_file(SYS_SLEEP, 9, input_buffer) == -1)
        {
            __android_log_write(ANDROID_LOG_ERROR, APPNAME, "Unable to get data from file. Cannot continue.");
            return 1;
        }

        if (strcmp(input_buffer, "sleeping") == 0)
        {
            __android_log_write(ANDROID_LOG_INFO, APPNAME, "Setting sleep profile.");
            set_cpu_params(conf.sleep_governor);
        }

        input_buffer[0] = '\0';
    }
    return 0;
}
