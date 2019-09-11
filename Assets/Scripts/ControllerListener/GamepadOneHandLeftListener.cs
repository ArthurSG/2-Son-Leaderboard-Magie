using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GamepadOneHandLeftListener : MonoBehaviour {

  private ControllerFilter controllerFilter;

  public int controllerIndex = 4;
  public string controllerName = "GamepadOneHandLeft";

  void Start (){
    controllerFilter = GetComponent<ControllerFilter>();
  }

  // Update is called once per frame
  void Update() {
    if(Input.GetButtonDown("LeftBumper"))
      controllerFilter.CallPrimaryAction(controllerIndex);
    if (Input.GetButtonDown("SecondaryActionGamepadOneHandLeft"))
      controllerFilter.CallSecondaryAction(controllerIndex);

    HandlePrimaryAxis();
    HandleSecondaryAxis();

  }

  void HandlePrimaryAxis() {
    float x = Input.GetAxis("LeftStickXAxis");
    float y = Input.GetAxis("LeftStickYAxis");

    if(!(x == 0 && y == 0)){
      controllerFilter.CallSetPrimaryAxis(controllerIndex,x,y);
    }
  }

  void HandleSecondaryAxis() {
    float x = Input.GetAxis("LeftStickXAxis");
    float y = Input.GetAxis("LeftStickYAxis");
    if(Mathf.Abs(x) >= 0.5 || Mathf.Abs(y) >= 0.5)
      controllerFilter.CallSetSecondaryAxis(controllerIndex,x,y);
  }
}

