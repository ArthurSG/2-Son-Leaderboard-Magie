using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class PressurePlate : Activateur {

  [FormerlySerializedAs("TempsRemonter")] public float tempsRemonter; //temps entre la sortie du personnage 
  [FormerlySerializedAs("notInTP")] public bool notInTp = false;
  private Slider timeBar;
  private Timer currentTimer = new Timer(0);
  private int pressured = 0;
  private Collider2D col;

  // Start is called before the first frame update
  void Start() {
    FetchComponents();
  }

  protected override void Update()
  {
      base.Update();
  }

  protected override void ActifUpdate()
  {
      if (pressured == 0)
          UpdateBar();
      base.ActifUpdate();
  }

  public override void Activer()
  {
      base.Activer();
      timeBar.gameObject.SetActive(true);
      timeBar.value = 1;
  }

  public override void Desactiver()
  {
      base.Desactiver();
      timeBar.gameObject.SetActive(false);
  }

  void FetchComponents(){
    col = GetComponent<Collider2D>();
    timeBar = transform.GetChild(0).GetChild(0).GetComponent<Slider>();
    timeBar.gameObject.SetActive(false);
  }

  private void OnTriggerEnter2D(Collider2D other) {
    if (notInTp && GameManager.instance.avatar.isInTP) return;
    if (pressured == 0) {
      Activer();
    }
    pressured++;
  }

  private void OnTriggerExit2D(Collider2D other)
  {
    pressured--;
    if (pressured <= 0) {
        if (currentTimer.IsStarted())
            currentTimer.Reset();
        currentTimer = new Timer(tempsRemonter, Desactiver);
        currentTimer.Play();
    }
  }

  private void UpdateBar()
  {
      float valueRemap = Utils.Remap(currentTimer.Time, 0, currentTimer.EndTime, 1, 0);
      timeBar.value = valueRemap;
  }
}
