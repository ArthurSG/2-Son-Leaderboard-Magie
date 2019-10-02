using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Receptacle : Interactable {
  private bool containCristal;
  private void Start() {
  }

  public bool isActive(){
    return containCristal;
  }

  override public void Interact(){
    if (containCristal) {
      Decharger();
    }
    else { Charger(); 
    }
  }

  private void Charger(){
    if (GameManager.instance.avatar.HasCristal()) {
      containCristal = true;
      GameManager.instance.avatar.SupprCristal();
      GetComponent<Activateur>().Activer();
      GetComponent<SpriteRenderer>().color = Color.green;
    }
  }

  private void Decharger(){
      containCristal = false;
      GameManager.instance.avatar.AddCristal();
    GetComponent<Activateur>().Desactiver();

    GetComponent<SpriteRenderer>().color = Color.red;
  }
}
