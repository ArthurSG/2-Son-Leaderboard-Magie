using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GamepadOneHandRightListener : MonoBehaviour {

  private ControllerFilter controllerFilter;

  public int controllerIndex = 5;
  public string controllerName = "GamepadOneHandRight";

  private float triggersDeadZone = 0.5f;
  private bool isTriggerPressed;

  void Start (){
    controllerFilter = GetComponent<ControllerFilter>();
  }

  // Update is called once per frame
  void Update() {
  	print (Input.GetAxis("RightTrigger"));
    if(Input.GetButtonDown("RightBumper")){
      controllerFilter.CallPrimaryAction(controllerIndex);
    }
    if (-Input.GetAxis("RightTrigger") > triggersDeadZone && !isTriggerPressed){
      isTriggerPressed = true;
      controllerFilter.CallSecondaryAction(controllerIndex);
    }
    else if (-Input.GetAxis("RightTrigger") <= triggersDeadZone && isTriggerPressed){
      isTriggerPressed = false;
    }

    HandlePrimaryAxis();
    HandleSecondaryAxis();

  }

  void HandlePrimaryAxis() {
    float x = Input.GetAxis("RightStickXAxis");
    float y = Input.GetAxis("RightStickYAxis");

    if(!(x == 0 && y == 0)){
      controllerFilter.CallSetPrimaryAxis(controllerIndex,x,y);
    }
  }

  void HandleSecondaryAxis() {
    float x = Input.GetAxis("RightStickXAxis");
    float y = Input.GetAxis("RightStickYAxis");
    if(Mathf.Abs(x) >= 0.5 || Mathf.Abs(y) >= 0.5)
      controllerFilter.CallSetSecondaryAxis(controllerIndex,x,y);
  }
}
