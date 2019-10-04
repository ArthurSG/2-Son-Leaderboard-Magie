using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Livre : MonoBehaviour {
  private MenuManager manager;
  private Animator animator;
  public MenuPage page;

  [SerializeField]
  private string ID;

  [SerializeField] [TextArea(3, 5)]
  private string Content;

  void Start() {
    manager = MenuManager.instance;
    animator = GetComponent<Animator>();
  }

  private void OnTriggerEnter2D(Collider2D collision) {
    page.transform.GetChild(0).GetComponent<Text>().text = ID;
    page.transform.GetChild(1).GetComponent<Text>().text = Content;
    animator.SetBool("Opened", true);
    manager.SwapUIMenu(page);
  }

  private void OnTriggerExit2D (Collider2D collision) {
    animator.SetBool("Opened", false);
    manager.Return();
  }

}
