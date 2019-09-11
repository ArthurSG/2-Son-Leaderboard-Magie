using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GamepadTacticListener : MonoBehaviour {

  private ControllerFilter controllerFilter;

  public int controllerIndex = 3;
  public string controllerName = "GamepadTactic";

  void Start (){
    controllerFilter = GetComponent<ControllerFilter>();
  }

  // Update is called once per frame
  void Update() {
    if(Input.GetButtonDown("PrimaryActionGamepad"))
      controllerFilter.CallPrimaryAction(controllerIndex);
    if (Input.GetButtonDown("SecondaryActionGamepad"))
      controllerFilter.CallSecondaryAction(controllerIndex);

    HandlePrimaryAxis();
    HandleSecondaryAxis();

  }

  void HandlePrimaryAxis() {
    float x = Input.GetAxis("PrimaryAxisXGamepad");
    float y = Input.GetAxis("PrimaryAxisYGamepad");

    if(!(x == 0 && y == 0)){
      controllerFilter.CallSetPrimaryAxis(controllerIndex,x,y);
    }
  }

  void HandleSecondaryAxis() {
    float x = Input.GetAxis("SecondaryAxisXGamepadTactic");
    float y = Input.GetAxis("SecondaryAxisYGamepadTactic");
    if(Mathf.Abs(x) >= 0.5 || Mathf.Abs(y) >= 0.5)
      controllerFilter.CallSetSecondaryAxis(controllerIndex,x,y);
  }
}
