#define G_SETTINGS_ENABLE_BACKEND 1
#include <gio/gio.h>
#include <gio/gsettingsbackend.h>

#define KPATH "/org/mwptools/planner/"

extern GSettingsBackend* get_key_file_backend(const char* , const char* );
