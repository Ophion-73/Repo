Shader "Unlit/Bandera"
{
    Properties
    {
        _Color ("Flag Color", Color) = (0.0, 0.7, 1.0, 1.0) // Color de la bandera (puedes cambiarlo)
        _Speed ("Speed", Range(0, 10)) = 1.0 // Velocidad de la onda
        _Intensity ("Intensity", Range(0, 1)) = 0.5 // Intensidad del movimiento
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float _Speed;
            float _Intensity;

            // Estructura de entrada (Datos del vértice)
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            // Estructura de salida (Datos para el fragment shader)
            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0; // Posición mundial para la onda
            };

            // Vertex Shader: Transformación de la posición del vértice y cálculo de la posición mundial
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex); // Convertimos la posición del objeto a espacio de clip
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; // Calculamos la posición en el espacio mundial
                return o;
            }

            // Fragment Shader: Aplicamos el movimiento de onda y el color
            fixed4 frag(v2f i) : SV_Target
            {
                // Calculamos el desplazamiento de onda en función de la posición mundial y el tiempo
                float offset = sin((i.worldPos.x + _Time.y * _Speed) * 0.5) * _Intensity;

                // Aplicamos el color base de la bandera con el movimiento
                float3 color = _Color.rgb + offset;

                // Evitamos que el color se salga de los límites (debe ser entre 0 y 1)
                color = saturate(color);

                return fixed4(color, 1.0); // Color sólido sin transparencia
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
