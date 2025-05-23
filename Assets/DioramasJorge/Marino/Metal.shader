Shader "Unlit/Metal"
{
    Properties
    {
        _Color ("Base Color", Color) = (0.5, 0.5, 0.5, 1)  // Gris uniforme
        _TimeSpeed ("Time Speed", Range(0, 10)) = 1  // Velocidad del movimiento
        _MovementStrength ("Movement Strength", Range(0, 1)) = 0.1 // Fuerza del movimiento
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
            float _TimeSpeed;
            float _MovementStrength;

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
                float2 uv : TEXCOORD0;
            };

            // Vertex Shader: aplicar el movimiento interno a la posición
            Varyings vert(Attributes v)
            {
                Varyings o;

                // Movimiento sobre la posición del vértice para crear un desplazamiento
                float time = _Time.y * _TimeSpeed;
                float movement = sin(time + v.position.x * 0.5) * _MovementStrength;  // Movimiento basado en la posición X del vértice

                // Aplicamos el movimiento al vértice
                v.position.y += movement; // Desplazamos solo en el eje Y para un movimiento interno

                // Convertir la posición del objeto al espacio de clip
                o.position = TransformObjectToHClip(v.position);

                o.uv = v.uv;
                return o;
            }

            // Fragment Shader: color gris uniforme
            half4 frag(Varyings i) : SV_Target
            {
                // Devolver el color base gris
                return _Color;
            }

            ENDHLSL
        }
    }

    FallBack "Unlit/Color"
}
