using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Activateur : MonoBehaviour
{
  public List<Activable> activables;
  private bool actif;

  protected virtual void Update()
  {
      if (actif)
          ActifUpdate();
  }

  protected virtual void Activer() {
    if (!actif) {
      actif = true;
      foreach (Activable act in activables)
        act.Activer();
    }
  }

  protected virtual void Desactiver(){
    if (actif) {
      actif = false;
      foreach (Activable act in activables)
        act.Desactiver();
    }
  }

  protected virtual void ActifUpdate(){}
}
