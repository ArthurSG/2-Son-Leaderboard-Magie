using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Activateur : MonoBehaviour
{
  public List<Activable> activables = new List<Activable>();
  private List<Activable> activablesCheck = new List<Activable>(); //Used for inspector value update
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


    protected virtual void OnValidate()
  {
      foreach (Activable activable in activables)
      {
          if (activable == null) continue;
          if (!activable.linkedActivateurs.Contains(this))
          {
                activable.linkedActivateurs.Add(this);
          }
      }

      foreach (Activable activable in activablesCheck)
      {
          if (activable == null) continue;
          if (!activables.Contains(activable)) // We removed an item from the list
          {
              if (activable.linkedActivateurs.Contains(this))
              {
                  activable.linkedActivateurs.Remove(this); // On remove l'objet de l'autre liste
              }
          }
      }

      activablesCheck = new List<Activable>(activables);
  }
}
