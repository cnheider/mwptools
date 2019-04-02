#define G_SETTINGS_ENABLE_BACKEND 1
#include <gio/gio.h>
#include <gio/gsettingsbackend.h>

GSettings* use_key_file(char * fname, char *schema, char* path, char* group)
{
    GSettings *settings;
    GSettingsBackend* settings_backend;
    settings_backend = g_keyfile_settings_backend_new (fname, path, group);
    settings = g_settings_new_with_backend (schema, settings_backend);
    return settings;
}
