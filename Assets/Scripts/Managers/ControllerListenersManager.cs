using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControllerListenersManager : MonoBehaviour
{
		private int numberOfControllerListeners;
		public List <MonoBehaviour> ControllerListeners;

    void Start()
    {
        numberOfControllerListeners = ControllerListeners.Count;
    }

    void Update()
    {
        if (Input.GetKeyDown("1"))
        	SwitchControllerListenerState(0);
        if (Input.GetKeyDown("2"))
        	SwitchControllerListenerState(1);
        if (Input.GetKeyDown("3"))
        	SwitchControllerListenerState(2);
        if (Input.GetKeyDown("4"))
        	SwitchControllerListenerState(3);
    }

    void SwitchControllerListenerState (int controllerListenerIndex)
    {
    	for (int i = 0; i < numberOfControllerListeners; i++){
    		ControllerListeners[i].enabled = false;
    	}
    	if (controllerListenerIndex < numberOfControllerListeners)
    		ControllerListeners[controllerListenerIndex].enabled = true;
    }


}
