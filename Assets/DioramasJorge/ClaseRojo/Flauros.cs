using UnityEngine;

[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]

public class Flauros : MonoBehaviour
{
    public Material material;

    void Start()
    {
        CreateFlauros();
    }

    private void CreateFlauros()
    {
        Vector3[] vertices =
        {
            //Tetraedro 1
            new Vector3(0, 0, 0), //0
            new Vector3(1, 0, 0), //1
            new Vector3(0, 0, 0), //2
            new Vector3(0.5f, 0.82f, 0.29f), //3
            new Vector3(0.5f, 0, 0.87f), //4
            new Vector3(0, 0, 0), //5
            
            //Tetraedro 2
            new Vector3(2, 0, 0), //6
            new Vector3(1, 0, 0), //7
            new Vector3(1.5f, 0.82f, 0.29f), //8
            new Vector3(2, 0, 0), //9
            new Vector3(1.5f, 0, 0.87f), //10
            new Vector3(2, 0, 0), //11
            
            //Tetraedro 3
            new Vector3(1, 0, 1.73f), //12
            new Vector3(1.5f, 0, 0.87f), //13
            new Vector3(1, 0, 1.73f), //14
            new Vector3(0.5f, 0, 0.87f), //15
            new Vector3(1, 0.82f, 1.15f), //16
            new Vector3(1, 0, 1.73f), //17
            
            //Tetraedro 4
            new Vector3(1, 1.63f, 0.58f), //18
            new Vector3(1.5f, 0.82f, 0.29f), //19
            new Vector3(0.5f, 0.82f, 0.29f), //20
            new Vector3(1, 1.63f, 0.58f), //21
            new Vector3(1, 0.82f, 1.15f), //22
            new Vector3(1, 1.63f, 0.58f), //23

            //Figura rara
            new Vector3(0.5f, 0.82f, 0.29f), //24
            new Vector3(0.5f, 0, 0.87f), //25
            new Vector3(1.5f, 0.82f, 0.29f), //26
            new Vector3(1, 0, 0), //27
            new Vector3(1.5f, 0, 0.87f), //28
            new Vector3(0.5f, 0, 0.87f), //29
            new Vector3(1.5f, 0.82f, 0.29f), //30
            new Vector3(1, 0.82f, 1.15f), //31
            new Vector3(0.5f, 0.82f, 0.29f), //32
            new Vector3(0.5f, 0, 0.87f) //33
        };

        int[] triangles =
        {
            //Tetraedro 1
            0, 3, 1, //front face
            1, 3, 4, //right face
            4, 3, 5, //left face
            4, 2, 1, //buttom face


            //Tetraedro 2
            7, 8, 6, //front face
            11, 8, 10, //right face
            10, 8, 7, //left face
            10, 7, 9, //buttom face

            //Tetraedro 3
            15, 16, 13, //front face
            13, 16, 14, //right face
            17, 16, 15, //left face
            12, 15, 13, //buttom face

            //Tetraedro 4
            22, 23, 20, //front face
            20, 18, 19, //right face
            19, 21, 22, //left face
            19, 22, 20, //buttom face

            //Figura Rara
            25, 24, 27, //1
            27, 24, 26, //2
            27, 26, 28, //3
            29, 27, 28, //4
            28, 31, 29, //5
            28, 30, 31, //6
            32, 31, 30, //7
            33, 31, 32, //8
        };

        Vector2[] uvs = 
        {
            //Tetraedro 1
            new Vector2(0.04509f, 0.64516f), //0
            new Vector2(0.03963f, 0.39746f), //1
            new Vector2(0.03963f, 0.14573f), //2
            new Vector2(0.21342f, 0.5203f), //3
            new Vector2(0.21342f, 0.26857f), //4
            new Vector2(0.38174f, 0.39746f), //5
            
            //Tetraedro 2
            new Vector2(0.04509f, 0.70101f), //6
            new Vector2(0.21342f, 0.82659f), //7
            new Vector2(0.21342f, 0.57846f), //8
            new Vector2(0.38174f, 0.95066f), //9
            new Vector2(0.38174f, 0.70101f), //10
            new Vector2(0.38174f, 0.45288f), //11
            
            //Tetraedro 3
            new Vector2(0.43184f, 0.98848f), //12
            new Vector2(0.43184f, 0.73732f), //13
            new Vector2(0.43184f, 0.48767f), //14
            new Vector2(0.59861f, 0.85836f), //15
            new Vector2(0.59861f, 0.61174f), //16
            new Vector2(0.76713f, 0.73732f), //17
            
            //Tetraedro 4
            new Vector2(0.61792f, 0.59207f), //18
            new Vector2(0.78819f, 0.71614f), //19
            new Vector2(0.78819f, 0.46649f), //20
            new Vector2(0.95847f, 0.84021f), //21
            new Vector2(0.95847f, 0.59207f), //22
            new Vector2(0.95847f, 0.33486f), //23
            
            //Figura rara
            new Vector2(0.26332f, 0.28021f), //24
            new Vector2(0.26332f, 0.0285f), //25
            new Vector2(0.43711f, 0.404f), //26
            new Vector2(0.43711f, 0.15779f), //27
            new Vector2(0.60387f, 0.28021f), //28
            new Vector2(0.60387f, 0.0285f), //29
            new Vector2(0.77766f, 0.404f), //30
            new Vector2(0.77766f, 0.15779f), //31
            new Vector2(0.94969f, 0.28021f), //32
            new Vector2(0.94969f, 0.0285f) //33
        };


        Mesh mesh = GetComponent<MeshFilter>().mesh;
        MeshRenderer meshRenderer = GetComponent<MeshRenderer>();
        mesh.Clear();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.uv = uvs;
        meshRenderer.material = material;
        mesh.Optimize();
        mesh.RecalculateNormals();
    }
}
