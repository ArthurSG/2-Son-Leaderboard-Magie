using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[ExecuteInEditMode]
public abstract class Activable : MonoBehaviour {
  public int nombreSourcesRequiseMax;
  public List<Activateur> linkedActivateurs = new List<Activateur>();
  private List<Activateur> linkedActivateursCheck = new List<Activateur>();  //Used for inspector value update

  private int nombreSourcesRequise;  // nombreSourcesRequise si <= 0
  protected int NombreSourcesRequise {
    get => nombreSourcesRequise;

    set {
      if (value <= 0 && !actif) {
        ChangeState(true);
      }
      else if (value > 0 && actif) {
        ChangeState(false);
      }
      nombreSourcesRequise = value;
    }
  }

  protected bool actif;

  protected void Start() {
    NombreSourcesRequise = nombreSourcesRequiseMax;
  }

  public void Activer() {
    NombreSourcesRequise--;
    SetEtat();
  }

  public void Desactiver() {
    NombreSourcesRequise++;
    SetEtat();
  }

  protected virtual void ChangeState(bool state) {
    actif = state;
  }

  protected virtual void SetEtat() { }


  protected virtual void OnValidate() {
    foreach (var activateur in linkedActivateurs.Where(activateur => activateur != null).Where(activateur => !activateur.activables.Contains(this))) {
      activateur.activables.Add(this);
    }

    foreach (var activateur in from activateur in linkedActivateursCheck where activateur != null where !linkedActivateurs.Contains(activateur) where activateur.activables.Contains(this) select activateur) // On vient de supprimer un activateur lié
    {
      activateur.activables.Remove(this); // On remove l'objet de l'autre liste
    }

    linkedActivateursCheck = new List<Activateur>(linkedActivateurs);
  }
}
