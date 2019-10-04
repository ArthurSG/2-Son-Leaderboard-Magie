using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Receptacle : Interactable {
  [SerializeField] private bool containCristal;
  private Activateur activateur;
  private Animator animator;

  private void Start() {
    activateur = GetComponent<Activateur>();
    animator = GetComponent<Animator>();
    animator.SetBool("Active", containCristal);
  }

  public bool isActive(){
    return containCristal;
  }

  override public void Interact(){
    if (containCristal)
      Decharger();
    else 
      Charger(); 
  }

  private void Charger(){
    if (!GameManager.instance.avatar.HasCristal())
      return;
    containCristal = true;
    GameManager.instance.avatar.SupprCristal();
    animator.SetBool("Active", true);
    if (activateur != null)
      activateur.Activer();
  }

  private void Decharger(){
    containCristal = false;
    GameManager.instance.avatar.AddCristal();
    animator.SetBool("Active", false);
    if (activateur != null)
      activateur.Desactiver();
  }
}
