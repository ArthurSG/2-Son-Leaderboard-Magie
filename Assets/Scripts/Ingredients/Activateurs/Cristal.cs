using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cristal : MonoBehaviour
{
  private void OnTriggerEnter2D(Collider2D collision) {
    if (collision.gameObject.tag == "Player") {
      GameManager.instance.avatar.AddCristal();
      Destroy(this.gameObject);
    }
  }
}
