using System;
using System.CodeDom;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;
using Debug = System.Diagnostics.Debug;

public class ExteriorCollidersGenerator : MonoBehaviour
{

    private IEnumerable<GameObject> FetchAllGrounds()
    {
        return GameObject.FindGameObjectsWithTag("Walkable");
    }

    public void GenerateBorders() // Build a wall
    {
        RemoveExistingColliders();

        GameObject borders = new GameObject("BORDERS");
        borders.transform.SetParent(transform.parent);

        var rb2D = borders.AddComponent<Rigidbody2D>();
        rb2D.simulated = true;
        rb2D.bodyType = RigidbodyType2D.Static;

        borders.layer = LayerMask.NameToLayer("Wall");

        var compoColl = borders.AddComponent<CompositeCollider2D>();
        compoColl.generationType = CompositeCollider2D.GenerationType.Manual;
        compoColl.geometryType = CompositeCollider2D.GeometryType.Outlines;


        foreach (var ground in FetchAllGrounds())
        {
            GameObject newBorder = new GameObject(ground.name + "_Border");
            newBorder.transform.SetParent(borders.transform);

            newBorder.transform.position = ground.transform.position;
            newBorder.transform.rotation = ground.transform.rotation;
            newBorder.transform.localScale = ground.transform.localScale;

            Type collType = ground.GetComponent<Collider2D>().GetType();

            Type box2D = typeof(BoxCollider2D);

            if (collType == box2D)
            {
                var coll = newBorder.AddComponent<BoxCollider2D>();
                coll.usedByComposite = true;
                coll.offset = ground.GetComponent<BoxCollider2D>().offset;
                coll.size = ground.GetComponent<BoxCollider2D>().size;
            }
            else
            {
                throw new NotImplementedException("Type of collider not implemented. Please ask nicely a programmer.");
            }
            
        }

        compoColl.GenerateGeometry();
    }

    private void RemoveExistingColliders()
    {
        GameObject.DestroyImmediate(GameObject.Find("BORDERS"));
    }

}
