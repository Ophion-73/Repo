using UnityEngine;

public class BotonesInicio : MonoBehaviour
{
    public GameObject panelInicio;
    public GameObject panelRandom;
    public GameObject panelManual;

    public void MenuRandom()
    {
        panelInicio.SetActive(false);
        panelRandom.SetActive(true);
    }

    public void MenuManual()
    {
        panelInicio.SetActive(false);
        panelManual.SetActive(true);
    }

    public void Salir()
    {
        Application.Quit();
    }
}
