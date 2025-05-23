using UnityEngine;


[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]

public class Triangulo : MonoBehaviour
{
    public Material material;
    //private float SpeedRotation = 50f;

    void Start()
    {
        CreateTrian();
    }

    void Update()
    {
        //transform.Rotate(Vector3.up, SpeedRotation * Time.deltaTime);
    }

    private void CreateTrian()
    {
        Vector3[] vertices =
        {
            new Vector3 (0, 0, 0), //0
            new Vector3 (1, 0, 0), //1
            new Vector3 (0.5f, 0.82f, 0.29f), //2
            new Vector3 (0.5f, 0, 0.87f), //3

            new Vector3 (2, 0, 0), //4
            new Vector3 (1.5f, 0.82f, 0.29f), //5
            new Vector3 (1.5f, 0, 0.87f), //6

            new Vector3 (1, 1.64f, 0.58f), //7
            new Vector3 (1, 0.82f, 1.16f), //8

            new Vector3 (1, 0, 1.74f) //9
        };

        int[] triangles =
        {
            //Triangulo 1
            0, 2, 1, //face front
            1, 2, 3, //right face
            3, 2, 0, //left face
            3, 0, 1, //down face

            //Triangulo 2
            1, 5, 4, //face front
            4, 5, 6, //right face
            6, 5, 1, //left face
            6, 1, 4, //down face

            //Triangulo 3
            2, 7, 5, //face front
            5, 7, 8, //right face
            8, 7, 2, //left face
            8, 2, 5, //down face

            //Triangulo 4
            3, 8, 6, //face front
            6, 8, 9, //right face
            9, 8, 3, //left face
            9, 3, 6, //down face



            //Figura rara
            1, 2, 5, //front face
            6, 5, 8, //right face
            3, 8, 2, //left face
            3, 1, 6 //down face
        };


        Mesh mesh = GetComponent<MeshFilter>().mesh;
        MeshRenderer meshRenderer = GetComponent<MeshRenderer>();
        mesh.Clear();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        meshRenderer.material = material;
        mesh.Optimize();
        mesh.RecalculateNormals();
    }
}
