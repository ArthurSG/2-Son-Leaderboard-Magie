using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GamepadListener : MonoBehaviour {






  // Update is called once per frame
  void Update() {
    if(Input.GetButtonDown("PrimaryActionGamepad"))
      PlayerController.instance.PrimaryAction();

    if (Input.GetButtonDown("SecondaryActionGamepad"))
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
    float x = Input.GetAxis("SecondaryAxisXGamepad");
    float y = Input.GetAxis("SecondaryAxisYGamepad");
    if(Mathf.Abs(x) >= 0.5 || Mathf.Abs(y) >= 0.5)
      PlayerController.instance.SetSecondaryAxis(x, y);
  }
}
