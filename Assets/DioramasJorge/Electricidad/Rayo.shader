Shader "Unlit/Rayo"
{
    Properties
    {
        _Color ("Base Color", Color) = (1, 1, 0, 1)  // Amarillo brillante
        _ShineStrength ("Shine Strength", Range(0, 5)) = 1.0  // Intensidad del brillo
        _NoiseStrength ("Noise Strength", Range(0, 1)) = 0.2  // Intensidad del movimiento interno
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Name "FORWARD"
            Tags { "LightMode"="ForwardBase" }

            HLSLPROGRAM
            #pragma target 4.5

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

            // Propiedades del material
            float4 _Color;
            float _ShineStrength;
            float _NoiseStrength;

            // Estructura de entrada
            struct Attributes
            {
                float4 position : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            // Estructura de salida
            struct Varyings
            {
                float4 position : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            // Vertex Shader: transformamos la posición y aplicamos el movimiento del rayo
            Varyings vert(Attributes v)
            {
                Varyings o;
                o.position = TransformObjectToHClip(v.position);  // Transformar a espacio de cámara
                o.normal = normalize(v.normal);  // Normalización de la normal

                // Movimiento rítmico para simular el rayo (ruido)
                o.position.x += sin(_Time.y * 5.0 + v.position.y) * _NoiseStrength;  // Desplazamiento en X
                o.position.z += cos(_Time.y * 5.0 + v.position.x) * _NoiseStrength;  // Desplazamiento en Z

                return o;
            }

            // Fragment Shader: brillo y color
            half4 frag(Varyings i) : SV_Target
            {
                // Brillo especular con la normal
                float shine = pow(max(0, dot(i.normal, float3(0, 0, 1))), 16.0) * _ShineStrength;

                // Aplicamos el color amarillo
                half4 finalColor = _Color + shine;

                // Devolvemos el color final
                return finalColor;
            }

            ENDHLSL
        }
    }

    FallBack "Unlit/Color"
}
