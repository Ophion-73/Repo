Shader "Unlit/oro"
{
    Properties
    {
        _Color ("Base Color", Color) = (1.0, 0.84, 0.0, 1)  // Oro (amarillo metálico)
        _ShineStrength ("Shine Strength", Range(0, 5)) = 1.0  // Intensidad del brillo
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

            // Vertex Shader: transformamos la posición y aplicamos el brillo
            Varyings vert(Attributes v)
            {
                Varyings o;
                o.position = TransformObjectToHClip(v.position);  // Transformar a espacio de cámara
                o.normal = normalize(v.normal);  // Normalización de la normal
                return o;
            }

            // Fragment Shader: brillo y color metálico
            half4 frag(Varyings i) : SV_Target
            {
                // Brillo especular con la normal (simulando el brillo metálico)
                float shine = pow(max(0, dot(i.normal, float3(0, 0, 1))), 16.0) * _ShineStrength;

                // Aplicamos el color dorado (oro)
                half4 finalColor = _Color + shine;

                // Devolvemos el color final con el brillo
                return finalColor;
            }

            ENDHLSL
        }
    }

    FallBack "Unlit/Color"
}
