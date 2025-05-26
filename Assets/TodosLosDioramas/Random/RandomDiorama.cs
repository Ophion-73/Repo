using UnityEngine;
using System.Collections.Generic;

public class RandomDiorama : MonoBehaviour
{
    public List<GameObject> emptys = new List<GameObject>(); // son 84 emptys los que tiene que haber

    public void RandomTodos()
    {
        DesactivarEmptys();
        int emptyRandom = Random.Range(0, emptys.Count);
        emptys[emptyRandom].SetActive(true);
    }

    public void RandomAlumno(int rangoAlumno)
    {
        int inicio = rangoAlumno * 12;
        int end = Mathf.Min(inicio + 12, emptys.Count);

        DesactivarEmptys();
        int emptyRandom = Random.Range(inicio, end);
        emptys[emptyRandom].SetActive(true);
    }

    private void DesactivarEmptys()
    {
        foreach (GameObject Emptys in emptys)
        {
            Emptys.SetActive(false);
        }
    }
}
