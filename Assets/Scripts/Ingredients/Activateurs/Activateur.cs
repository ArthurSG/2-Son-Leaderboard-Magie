using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[ExecuteInEditMode]
public class Activateur : MonoBehaviour {
  
  public List<Activable> activables = new List<Activable>();
  private List<Activable> activablesCheck = new List<Activable>(); //Used for inspector value update
  private bool actif;

  protected virtual void Update() {
    if (actif)
      ActifUpdate();
  }

  public virtual void Activer() {
    if (!actif) {
      actif = true;
      foreach (Activable act in activables)
        act.Activer();
    }
  }

  public virtual void Desactiver(){
    if (actif) {
      actif = false;
      foreach (Activable act in activables)
        act.Desactiver();
    }
  }

  protected virtual void ActifUpdate(){}


    protected virtual void OnValidate()
  {
      foreach (var activable in activables.Where(activable => activable != null).Where(activable => !activable.linkedActivateurs.Contains(this)))
      {
          activable.linkedActivateurs.Add(this);
      }

      foreach (var activable in from activable in activablesCheck where activable != null where !activables.Contains(activable) where activable.linkedActivateurs.Contains(this) select activable) // On vient de supprimer un activable lié
      {
          activable.linkedActivateurs.Remove(this); // On remove l'objet de l'autre liste
      }

      activablesCheck = new List<Activable>(activables);
  }
}
