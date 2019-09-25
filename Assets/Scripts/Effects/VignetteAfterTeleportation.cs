using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class VignetteAfterTeleportation : MonoBehaviour
{
  [Range(.1f, 1f)]
  public float minVignetteValue = .10f, maxVignetteValue = 1f;
  public float vignetteTime = .5f;
  public PostProcessVolume volume;
  private Vignette vignette;
  private Timer vignetteTimer;

  void Start() {
    vignetteTimer = new Timer(vignetteTime,OnApneaUpdate);
    vignetteTimer.OnTimerUpdate += OnApneaUpdate;
    volume.profile.TryGetSettings(out vignette);
  }

  public void Vignette() {
    vignetteTimer.ResetPlay();
  }

  // Blooming after teleportation
  void OnApneaUpdate() {
    vignette.intensity.value = Mathf.Lerp(minVignetteValue, maxVignetteValue, vignetteTimer.GetPercentageLeft());
  }
}
