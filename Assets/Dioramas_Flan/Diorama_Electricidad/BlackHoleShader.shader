Shader "Flan/BlackHoleShader"
{
    Properties
    {
        _EdgeColor("Edge Color", Color) = (1, 0.6, 0.2, 1)
        _Radius("Hole Radius", Float) = 0.3
        _EdgeWidth("Edge Width", Float) = 0.1
        _Distortion("Distortion Strength", Float) = 0.5
        _TimeSpeed("Animation Speed", Float) = 2.0
        _MainTex("Base Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _EdgeColor;
            float _Radius, _EdgeWidth, _Distortion, _TimeSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 uv = i.uv;
                float2 center = float2(0.5, 0.5);
                float2 dir = uv - center;
                float dist = length(dir);

                // Simular distorsión de lente
                float2 warpedUV = uv + normalize(dir) * (_Distortion / (dist + 0.05));

                // Samplear textura
                float4 texCol = tex2D(_MainTex, warpedUV);

                // Disco de acreción animado
                float pulse = sin(_Time.y * _TimeSpeed + dist * 20);
                float edgeMask = smoothstep(_Radius, _Radius + _EdgeWidth, dist);
                float4 edgeColor = _EdgeColor * pulse * (1.0 - edgeMask);

                // Núcleo negro
                float holeMask = step(dist, _Radius);
                float4 hole = float4(0, 0, 0, 1);

                return lerp(texCol + edgeColor, hole, holeMask);
            }
            ENDCG
        }
    }
}
