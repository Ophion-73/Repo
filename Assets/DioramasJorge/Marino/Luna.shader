Shader "Unlit/Luna"
{
    Properties
    {
        _Color ("Moon Color", Color) = (1, 1, 1, 1)
        _LightDirection ("Light Direction", Vector) = (0, 0, 1, 0)
        _Glossiness ("Glossiness", Range(0, 1)) = 0.5
        _Glow ("Glow", Range(0, 1)) = 0.1
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            Tags { "Queue"="Background" }
            ZWrite On
            ZTest LEqual
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
            };

            float4 _Color;
            float3 _LightDirection;
            float _Glow;
            float _Glossiness;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = v.normal;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Color uniforme para la luna
                float4 color = _Color;

                // Calculamos la iluminación difusa según la dirección de la luz (simulando el sol)
                float lightIntensity = max(dot(i.normal, normalize(_LightDirection)), 0);
                color.rgb *= lightIntensity;

                // Agregamos el brillo (Glow)
                color.rgb += _Glow;

                // Añadimos especularidad para simular reflejos de luz
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.pos.xyz);
                float3 halfVec = normalize(_LightDirection + viewDir);
                float spec = pow(max(dot(i.normal, halfVec), 0), _Glossiness * 128);
                color.rgb += spec;

                return color;
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
