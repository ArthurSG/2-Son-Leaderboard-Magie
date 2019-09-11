using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControllerFilter : MonoBehaviour
{

	public int activeControllerIndex = 0;
	public int numberOfListener = 2;
  
  void Start()
  {
        
  }

  void Update()
  {
        
  }

  public void CallSetPrimaryAxis (int controllerIndex, float x, float y){
  	PlayerController.instance.SetPrimaryAxis(x, y);
  	SetActiveController (controllerIndex);
  }

  public void CallSetSecondaryAxis (int controllerIndex, float x, float y){
  	PlayerController.instance.SetSecondaryAxis(x, y);
  	SetActiveController (controllerIndex);
  }


  public void CallPrimaryAction (int controllerIndex){
  		PlayerController.instance.PrimaryAction();
  		SetActiveController (controllerIndex);
  }

  public void CallSecondaryAction (int controllerIndex){
    	PlayerController.instance.SecondaryAction();
    	SetActiveController (controllerIndex);
  }
  

  void SetActiveController (int controllerIndex){
  	if (controllerIndex != activeControllerIndex)
  		activeControllerIndex = controllerIndex;
  }
}
