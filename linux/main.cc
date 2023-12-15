#include "AI_EYE_GUIDElication.h"

int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = AI_EYE_GUIDElication_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
