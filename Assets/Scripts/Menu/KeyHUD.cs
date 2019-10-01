using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class KeyHUD : MonoBehaviour
{
  public MenuPage keyOverlay;
  public float showTime;
  private Timer showTimer;
  public static KeyHUD instance;

  private void Start() {
    FetchStaticInstance();
    showTimer = new Timer(showTime, HidekeyOverlay);
  }

  public static void ShowKeys(){
    instance.ResetKeyAmount();
    MenuManager.instance.SwapUIMenu(instance.keyOverlay);
    instance.showTimer.ResetPlay();
  }

  private void HidekeyOverlay(){
    MenuManager.instance.Return();
  }

  private void FetchStaticInstance(){
    if (instance != null)
      print("multiple instances of KeyHUD singleton");
    instance = this;
  }

  void ResetKeyAmount(){
    keyOverlay.transform.GetChild(0).GetComponent<Text>().text = GameManager.instance.avatar.Keys.ToString();
  }
}
