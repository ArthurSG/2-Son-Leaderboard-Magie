using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Activateur : MonoBehaviour
{
  public List<Activable> activables;
  private bool actif;

  protected void Activer() {
    if (!actif) {
      actif = true;
      foreach (Activable act in activables)
        act.Activer();
    }
  }

  protected void Desactiver(){
    if (actif) {
      actif = false;
      foreach (Activable act in activables)
        act.Desactiver();
    }
  }
}
