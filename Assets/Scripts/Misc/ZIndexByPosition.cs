using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZIndexByPosition : MonoBehaviour {
  public SpriteRenderer spriteRenderer;
  public bool updated = false;
  private int distancePrecision = 10;
  void Start() {
    spriteRenderer.sortingOrder = (int) (-1 * transform.position.y * distancePrecision); 
  }

  void Update() {
    if (updated)
      spriteRenderer.sortingOrder = (int) (-1 * transform.position.y * distancePrecision);
  }
  
}
