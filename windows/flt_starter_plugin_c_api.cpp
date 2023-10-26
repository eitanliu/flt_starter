#include "include/flt_starter/flt_starter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flt_starter_plugin.h"

void FltStarterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flt_starter::FltStarterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
