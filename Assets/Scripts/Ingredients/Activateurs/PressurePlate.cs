using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PressurePlate : Activateur {

  public float TempsRemonter; //temps entre la sortie du personnage 
  public bool notInTP = false;
  private float Pressured = 0;
  private Collider2D col;

  // Start is called before the first frame update
  void Start() {
    FetchComponents();
  }

  // Update is called once per frame
  void Update() {

  }

  void FetchComponents(){
    col = GetComponent<Collider2D>();

  }

  private void OnTriggerEnter2D(Collider2D other) {
    if (notInTP && GameManager.instance.avatar.isInTP) return;
    if (Pressured == 0) {
      Activer();
    }
    Pressured++;
  }

  private void OnTriggerExit2D(Collider2D other)
  {
    Pressured--;
    if (Pressured <= 0) {
      Timer t = new Timer(TempsRemonter, Desactiver);
      t.Play();
    }
  }
}
