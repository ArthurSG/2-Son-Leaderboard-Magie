using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActivationReceiver : Activable {
  public MonoBehaviour[] linkedScripts;

  protected override void ChangeState(bool state) {
    base.ChangeState(state);

    if (state) {
      foreach (MonoBehaviour script in linkedScripts) {
        script.enabled = true;
      }

    }

    else {
      foreach (MonoBehaviour script in linkedScripts) {
        script.enabled = false;
      }

    }

    SpriteChange(state);
  }

  private void SpriteChange(bool state) {
    //TODO: Put Activated sprite or deactivated sprite
  }
}
