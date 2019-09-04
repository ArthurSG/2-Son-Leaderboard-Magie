using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GamepadListener : MonoBehaviour {

  // Update is called once per frame
  void Update() {
    if(Input.GetButtonDown("PrimaryAction"))
      PlayerController.instance.PrimaryAction();

    if (Input.GetButtonDown("SecondaryAction"))
      PlayerController.instance.SecondaryAction();

    HandlePrimaryAxis();
    HandleSecondaryAxis();

  }

  void HandlePrimaryAxis() {
    float x = Input.GetAxis("PrimaryAxisX");
    float y = Input.GetAxis("PrimaryAxisY");
    if(!(x == 0 && y == 0))
      PlayerController.instance.SetPrimaryAxis(x,y);
  }

  void HandleSecondaryAxis() {
    float x = Input.GetAxis("SecondaryAxisX");
    float y = Input.GetAxis("SecondaryAxisY");
    if(!(x == 0 && y == 0))
      PlayerController.instance.SetSecondaryAxis(x, y);
  }
}
