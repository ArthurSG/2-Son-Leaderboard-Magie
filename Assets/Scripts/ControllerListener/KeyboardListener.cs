using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyboardListener : ControllerListener {

  // Update is called once per frame
  void Update() {
    if(Input.GetButtonDown("ActionPrimaire")) {
      ActionPrimaire();
    }

    if (Input.GetButtonDown("ActionSecondaire")) {
      ActionSecondaire();
    }

    float x = Input.GetAxis("Horizontal");
    float y = Input.GetAxis("Vertical");
    PrimaryAxis(x, y);
  }
}
