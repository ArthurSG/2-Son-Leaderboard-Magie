using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoorC : MonoBehaviour
{
  private void OnTriggerEnter2D(Collider2D other) {
    if (other.gameObject.tag == "Player" && GameManager.instance.avatar.HasKey()) 
      Open();
  }

  private void Open() {
    GameManager.instance.avatar.SupprKey();
    foreach(Collider2D col in transform.GetComponentsInChildren<BoxCollider2D>())
      col.enabled = false;
  }
}
