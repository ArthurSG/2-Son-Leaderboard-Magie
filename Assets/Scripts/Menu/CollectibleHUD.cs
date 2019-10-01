using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CollectibleHUD : MonoBehaviour
{
  public MenuPage CollectibleOverlay;
  public float showTime;
  private Timer showTimer;
  public static CollectibleHUD instance;

  private void Start() {
    FetchStaticInstance();
    showTimer = new Timer(showTime, HideCollectibleOverlay);
  }

  public static void ShowOverlay(){
    instance.ResetAmounts();
    MenuManager.instance.SwapUIMenu(instance.CollectibleOverlay);
    instance.showTimer.ResetPlay();
  }

  private void HideCollectibleOverlay(){
    MenuManager.instance.Return();
  }

  void ResetAmounts(){
    CollectibleOverlay.transform.GetChild(0).GetComponent<Text>().text = GameManager.instance.avatar.Keys.ToString();
    CollectibleOverlay.transform.GetChild(1).GetComponent<Text>().text = GameManager.instance.avatar.Cristals.ToString();
  }

  private void FetchStaticInstance() {
    if (instance != null)
      print("multiple instances of CollectibleHUD singleton");
    instance = this;
  }
}
