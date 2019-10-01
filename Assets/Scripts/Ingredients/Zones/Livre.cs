using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Livre : MonoBehaviour
{
  public MenuManager manager;
  public MenuPage page;

  [SerializeField]
  private string ID;

  [SerializeField] [TextArea(3, 5)]
  private string Content;

  private void OnTriggerEnter2D(Collider2D collision) {
    page.transform.GetChild(0).GetComponent<Text>().text = ID;
    page.transform.GetChild(1).GetComponent<Text>().text = Content;

    manager.SwapUIMenu(page);
  }

  private void OnTriggerExit2D (Collider2D collision) {
    manager.Return();
  }

}
