using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FogCluster : MonoBehaviour {
  private List<SpriteFog> spritesInCluster = new List<SpriteFog>();
  private bool isShown = false;

  public float fogRevealTime = 1;

  // Start is called before the first frame update
  void Start() {
    FetchChildrenSprites();
    HideCluster();
  }

  private IEnumerator RevealSpritesInCluster() {
    float timer = 0;

    while (true) {
      foreach (SpriteFog spriteFog in spritesInCluster) {
        spriteFog.spriteRenderer.color = Vector4.Lerp(spriteFog.spriteRenderer.color, spriteFog.color,
            timer / fogRevealTime);
      }

      if (timer >= fogRevealTime)
        break;

      yield return null;
      timer += Time.deltaTime;
    }
  }

  public void RevealLevel() {
    isShown = true;
    StartCoroutine(RevealSpritesInCluster());
  }

  private void FetchChildrenSprites() {
    SpriteRenderer[] spriteRenderers = GetComponentsInChildren<SpriteRenderer>();

    foreach (var spriteRenderer in spriteRenderers) {
      spritesInCluster.Add(new SpriteFog(spriteRenderer));
    }
  }

  private void HideCluster() {
    foreach (SpriteFog spriteFog in spritesInCluster) {
      spriteFog.spriteRenderer.color = Color.black;
    }
  }

  private void OnTriggerEnter2D(Collider2D other) {
    if (other.CompareTag("Player") && !isShown) {
      RevealLevel();
    }
  }
}

public class SpriteFog {
  public SpriteRenderer spriteRenderer;
  public Color color;

  public SpriteFog(SpriteRenderer targetSpriteRenderer) {
    spriteRenderer = targetSpriteRenderer;
    color = targetSpriteRenderer.color;
  }

}
