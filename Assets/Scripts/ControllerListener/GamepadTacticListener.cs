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
    if(Input.GetButtonDown("RightBumper")){
      controllerFilter.CallPrimaryAction(controllerIndex);
    }
    if (Input.GetButtonDown("LeftBumper")){
      controllerFilter.CallSecondaryAction(controllerIndex);
    }

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
    float x = Input.GetAxis("RightStickXAxis");
    float y = Input.GetAxis("RightStickYAxis");
    if(Mathf.Abs(x) >= 0.5 || Mathf.Abs(y) >= 0.5)
      controllerFilter.CallSetSecondaryAxis(controllerIndex,x,y);
  }
}
