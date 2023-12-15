#ifndef FLUTTER_AI_EYE_GUIDELICATION_H_
#define FLUTTER_AI_EYE_GUIDELICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(MyApplication, AI_EYE_GUIDElication, MY, APPLICATION,
                     GtkApplication)

/**
 * AI_EYE_GUIDElication_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #MyApplication.
 */
MyApplication* AI_EYE_GUIDElication_new();

#endif  // FLUTTER_AI_EYE_GUIDELICATION_H_
