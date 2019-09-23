using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public abstract class Activable : MonoBehaviour {
  public int nombreSourcesRequiseMax;
  public List<Activateur> linkedActivateurs;
  private List<Activateur> linkedActivateursCheck = new List<Activateur>();  //Used for inspector value update

    private int nombreSourcesRequise;  // nombreSourcesRequise si <= 0
  protected int NombreSourcesRequise
  {
      get => nombreSourcesRequise;

      set
      {
          if (value <= 0 && !actif)
          {
              ChangeState(true);
          }
          else if (value > 0 && actif)
          {
              ChangeState(false);
          }
          nombreSourcesRequise = value;
      }
  }

  protected bool actif;

  protected void Start() {
      NombreSourcesRequise = NombreSourcesRequise;
  }

  public void Activer() {
      NombreSourcesRequise--;
      SetEtat();
  }

  public void Desactiver() {
      NombreSourcesRequise++;
      SetEtat();
  }

  protected virtual void ChangeState(bool state)
  {
      actif = state;
  }

  protected virtual void SetEtat(){}

  
  protected virtual void OnValidate()
  {
      foreach (Activateur activateur in linkedActivateurs)
      {
          if (!activateur.activables.Contains(this))
          {
              activateur.activables.Add(this);
          }
      }

      foreach (Activateur activateur in linkedActivateursCheck)
      {
          if (!linkedActivateurs.Contains(activateur)) // We removed an item from the list
          {
              if (activateur.activables.Contains(this))
              {
                  activateur.activables.Remove(this); // On remove l'objet de l'autre liste
              }
          }
      }

      linkedActivateursCheck = new List<Activateur>(linkedActivateurs);
    }
}
