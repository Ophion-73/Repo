Shader "Unlit/Madera"
{
    Properties
    {
        _Color ("Base Color", Color) = (0.6, 0.4, 0.2, 1.0) // Color de madera (marrón)
        _Speed ("Speed", Range(0, 10)) = 1.0 // Velocidad del movimiento
        _Intensity ("Intensity", Range(0, 1)) = 0.2 // Intensidad del movimiento
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float _Speed;
            float _Intensity;

            // Estructura de entrada
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            // Estructura de salida
            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
            };

            // Vertex Shader: Transformar la posición y calcular la posición mundial
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex); // Transformamos la posición a espacio de clip
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; // Calculamos la posición mundial
                return o;
            }

            // Fragment Shader: Aplicamos el color base y movimiento interno
            fixed4 frag(v2f i) : SV_Target
            {
                // Movimiento basado en el tiempo y la posición mundial
                float offset = sin((i.worldPos.x + i.worldPos.z + _Time.y * _Speed) * 3.0) * _Intensity;
                float3 color = _Color.rgb + offset;

                // Aseguramos que el color no sea negativo y no se vea oscuro
                color = saturate(color);

                return fixed4(color, _Color.a);
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
