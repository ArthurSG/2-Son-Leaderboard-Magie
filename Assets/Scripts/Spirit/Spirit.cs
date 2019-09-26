using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spirit : MonoBehaviour
{

    private GameObject avatar;
    private LineRenderer lineRend;

    private void Start()
    {
        FetchComponents();
        DisableOnStart();
    }

    private void Update()
    {
        SpiritLinkUpdate();
    }

    private void SpiritLinkUpdate()
    {
        Vector3[] linkPoses = new Vector3[] { transform.position, avatar.transform.position};
        lineRend.SetPositions(linkPoses);
    }

    private void FetchComponents()
    {
        avatar = GameManager.instance.avatar.gameObject;
        lineRend = GetComponent<LineRenderer>();
    }

    private void DisableOnStart()
    {
        transform.SetParent(null);
        gameObject.SetActive(false);
    }

    public void SetSpiritActive(bool state)
    {
        if (state)
        {
            transform.position = GameManager.instance.avatar.transform.position;
            SpiritLinkUpdate();
            gameObject.SetActive(true);
        }

        else
        {
            gameObject.SetActive(false);
        }
    }
}
