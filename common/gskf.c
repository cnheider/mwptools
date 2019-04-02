#define G_SETTINGS_ENABLE_BACKEND 1
#include <gio/gio.h>
#include <gio/gsettingsbackend.h>

#define KPATH "/org/mwptools/planner/"

GSettingsBackend* get_key_file_backend(char* fname, char* group)
{
    GSettingsBackend* settings_backend;
    return g_keyfile_settings_backend_new (fname, KPATH, group);
}
