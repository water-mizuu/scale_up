import "package:flutter/material.dart";
import "package:scale_up/hooks/providing_hook_widget.dart";

void useInit(void Function() callback) {
  useEffect(() {
    callback();
    return null;
  }, []);
}

void useDispose(void Function() callback) {
  useEffect(() {
    return callback;
  }, []);
}

void usePostFirstRender(void Function() callback) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }, []);
}

void usePostRender(void Function() callback) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  });
}
