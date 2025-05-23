using UnityEngine;

public class Dado20UV : MonoBehaviour
{
    public Material material;

    void Start()
    {
        CreateDado();
    }

    private void CreateDado()
    {
        Vector3[] vertices = 
        {
            new Vector3 (0.27639f, 0.44721f, -0.85064f), //0
            new Vector3 (0, 1, 0), //1
            new Vector3 (0.89442f, 0.44721f, 0), //2
            new Vector3 (0, 1, 0), //3
            new Vector3 (0.276385f, 0.447215f, 0.85064f), //4
            new Vector3 (0, 1, 0), //5
            new Vector3 (-0.7236f, 0.447215f, 0.52572f), //6
            new Vector3 (0, 1, 0), //7
            new Vector3 (-0.7236f, 0.447215f, -0.52572f), //8
            new Vector3 (0, 1, 0), //9
            new Vector3 (0.27639f, 0.44721f, -0.85064f), //10
            new Vector3 (0.7236f, -0.447215f, -0.52572f), //11
            new Vector3 (0, -1, 0), //12
            new Vector3 (-0.276385f, -0.447215f, -0.85064f), //13
            new Vector3 (0, -1, 0), //14
            new Vector3 (-0.894425f, -0.447215f, 0), //15
            new Vector3 (0, -1, 0), //16
            new Vector3 (-0.276385f, -0.447215f, 0.85064f), //17
            new Vector3 (0, -1, 0), //18
            new Vector3 (0.7236f, -0.447215f, 0.52572f), //19
            new Vector3 (0, -1, 0), //20
            new Vector3 (0.7236f, -0.447215f, -0.52572f) //21
        };

        int[] triangles = 
        {
            0, 1, 2, //0
            2, 3, 4, //1
            4, 5, 6, //2
            6, 7, 8, //3
            8, 9, 10, //4
            13, 8, 10, //5
            13, 10, 11, //6
            12, 13, 11, //7
            14, 15, 13, //8
            16, 17, 15, //9
            18, 19, 17, //10
            20, 21, 19, //11
            21, 0, 2, //12
            21, 2, 19, //13
            19, 2, 4, //14
            19, 4, 17, //15
            17, 4, 6, //16
            17, 6, 15, //17
            15, 6, 8, //18
            15, 8, 13 //19
        };

        Vector2[] uvs = 
        {
            new Vector2(0.343329f, 0.024031f), //0
            new Vector2(0.029984f, 0.110389f), //1
            new Vector2(0.343329f, 0.196746f), //2
            new Vector2(0.029984f, 0.283103f), //3
            new Vector2(0.343329f, 0.369461f), //4
            new Vector2(0.029984f, 0.455818f), //5
            new Vector2(0.343329f, 0.542175f), //6
            new Vector2(0.029984f, 0.628533f), //7
            new Vector2(0.343329f, 0.71489f), //8
            new Vector2(0.029984f, 0.801247f), //9
            new Vector2(0.343329f, 0.887605f), //10
            new Vector2(0.656671f, 0.973963f), //11
            new Vector2(0.970016f, 0.887605f), //12
            new Vector2(0.656671f, 0.801247f), //13
            new Vector2(0.970016f, 0.71489f), //14
            new Vector2(0.656671f, 0.628533f), //15
            new Vector2(0.970016f, 0.542175f), //16
            new Vector2(0.656671f, 0.455818f), //17
            new Vector2(0.970016f, 0.369461f), //18
            new Vector2(0.656671f, 0.283103f), //19
            new Vector2(0.970016f, 0.196746f), //20
            new Vector2(0.656671f, 0.110388f), //21
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
