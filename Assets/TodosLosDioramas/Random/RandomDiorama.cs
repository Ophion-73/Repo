using UnityEngine;
using System.Collections.Generic;

public class RandomDiorama : MonoBehaviour
{
    public List<GameObject> emptys = new List<GameObject>(); // son 84 emptys los que tiene que haber
    public GameObject card;
    public Texture2D[] cardTex;

    public int indexSeleccionado;

    private int[,] rangosOrdenados = new int[,]
    {
        { 0, 11 },   // Barrera
        { 12, 23 },  // Angel
        { 24, 35 },  // Cesar
        { 36, 47 },  // Flan
        { 48, 59 },  // Marche
        { 60, 71 },  // Jorge
        { 72, 83 }   // Juan
    };

    private int ultimoActivo = -1;

    public void RandomTodos()
    {
        if (emptys.Count <= 1) return;

        int nuevoEmpty;

        do
        {
            nuevoEmpty = Random.Range(0, emptys.Count);
        } while (nuevoEmpty == ultimoActivo);

        DesactivarEmptys();
        emptys[nuevoEmpty].SetActive(true);
        ultimoActivo = nuevoEmpty;
        CambiarTextura(nuevoEmpty);
    }

    public void RandomAlumno(int rangoAlumno)
    {
        if (rangoAlumno < 0 || rangoAlumno >= rangosOrdenados.GetLength(0))
        {
            Debug.Log("Fuera rango");
            return;
        }

        int start = rangosOrdenados[rangoAlumno, 0];
        int end = rangosOrdenados[rangoAlumno, 1] + 1;

        int nuevoEmpty;

        do
        {
            nuevoEmpty = Random.Range(start, end);
        } while (nuevoEmpty == ultimoActivo);

        DesactivarEmptys();
        emptys[nuevoEmpty].SetActive(true);
        ultimoActivo = nuevoEmpty;
        CambiarTextura(nuevoEmpty);
    }

    private void DesactivarEmptys()
    {
        foreach (GameObject Emptys in emptys)
        {
            Emptys.SetActive(false);
        }
    }

    public void CambiarTextura(int index)
    {
        card.GetComponent<MeshRenderer>().material.mainTexture = cardTex[index];
    }

    public void SeleccionDeCarta(int index)
    {
        DesactivarEmptys();
        emptys[index].SetActive(true);
        card.GetComponent<MeshRenderer>().material.mainTexture = cardTex[index];
    }

    public void ActivarSeleccionManual()
    {
        if (indexSeleccionado < 0 || indexSeleccionado >= emptys.Count)
        {
            Debug.LogWarning("Índice fuera de rango");
            return;
        }

        SeleccionDeCarta(indexSeleccionado);
    }
}
