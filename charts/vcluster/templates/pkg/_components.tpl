{{/*
    Components Workload Labels
*/}}
{{- define "pkg.components.labels" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $labels := $.labels -}}
  {{- with $components.workloads.labels -}}
    {{- $labels = mergeOverwrite $labels . -}}
  {{- end -}}
  {{- if $labels -}}
    {{- printf "%s" (toYaml $labels) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Pod Labels
*/}}
{{- define "pkg.components.pod_labels" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $labels := $.labels -}}
  {{- with $components.workloads.podLabels -}}
    {{- $labels = mergeOverwrite $labels . -}}
  {{- end -}}
  {{- if $labels -}}
    {{- printf "%s" (toYaml $labels) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Workload Annotations
*/}}
{{- define "pkg.components.annotations" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $annotations := $.annotations -}}
  {{- with $components.workloads.annotations -}}
    {{- $annotations = mergeOverwrite $annotations . -}}
  {{- end -}}
  {{- if $annotations -}}
    {{- printf "%s" (toYaml $annotations) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Pod Annotations
*/}}
{{- define "pkg.components.pod_annotations" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $annotations := $.annotations -}}
  {{- with $components.workloads.podAnnotations -}}
    {{- $annotations = mergeOverwrite $annotations . -}}
  {{- end -}}
  {{- if $annotations -}}
    {{- printf "%s" (toYaml $annotations) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Service Annotations
*/}}
{{- define "pkg.components.svc_annotations" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $annotations := $.annotations -}}
  {{- with $components.service.annotations -}}
    {{- $annotations = mergeOverwrite $annotations . -}}
  {{- end -}}
  {{- if $annotations -}}
    {{- printf "%s" (toYaml $annotations) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Service Labels
*/}}
{{- define "pkg.components.svc_labels" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $labels := $.labels -}}
  {{- with $components.service.labels -}}
    {{- $labels = mergeOverwrite $labels . -}}
  {{- end -}}
  {{- if $labels -}}
    {{- printf "%s" (toYaml $labels) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Affinity
*/}}
{{- define "pkg.components.affinity" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $affinity := $.affinity -}}
  {{- if $components.workloads.affinity -}}
    {{- $affinity = $components.workloads.affinity -}}
  {{- end -}}
  {{- if $affinity -}}
    {{- printf "%s" (toYaml $affinity) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components tolerations
*/}}
{{- define "pkg.components.tolerations" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $tolerations := $.tolerations -}}
  {{- if $components.workloads.tolerations -}}
    {{- $tolerations = $components.workloads.tolerations -}}
  {{- end -}}
  {{- if $tolerations -}}
    {{- printf "%s" (toYaml $tolerations) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Nodeselector
*/}}
{{- define "pkg.components.nodeselector" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $nodeselector := $.nodeSelector -}}
  {{- if $components.workloads.nodeSelector -}}
    {{- $nodeselector = $components.workloads.nodeSelector -}}
  {{- end -}}
  {{- if $nodeselector -}}
    {{- printf "%s" (toYaml $nodeselector) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components TopologySpreadConstraint
*/}}
{{- define "pkg.components.topologySpreadConstraints" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $topologySpreadConstraints := $.tsc -}}
  {{- if $components.workloads.topologySpreadConstraints -}}
    {{- $topologySpreadConstraints = $components.workloads.topologySpreadConstraints -}}
  {{- end -}}
  {{- if $topologySpreadConstraints -}}
    {{- printf "%s" (toYaml $topologySpreadConstraints) -}}
  {{- end -}}
{{- end -}}


{{/*
    Components Priority Class
*/}}
{{- define "pkg.components.priorityClass" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $class := $.pc -}}
  {{- if $components.workloads.priorityClassName -}}
    {{- $class = $components.workloads.priorityClassName -}}
  {{- end -}}
  {{- if $class -}}
    {{- printf "%s" $class -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Pod Security Context
*/}}
{{- define "pkg.components.podSecurityContext" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $psc := $.psc -}}
  {{- if $components.workloads.podSecurityContext -}}
    {{- $psc = $components.workloads.podSecurityContext -}}
  {{- end -}}
  {{- if $psc.enabled -}}
    {{- printf "%s" (toYaml (omit $psc "enabled")) -}}
  {{- end -}}
{{- end -}}

{{/*
    Components Security Context
*/}}
{{- define "pkg.components.securityContext" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $sc := $.sc -}}
  {{- if $components.workloads.securityContext -}}
    {{- $sc = $components.workloads.securityContext -}}
  {{- end -}}
  {{- if $sc.enabled -}}
    {{- printf "%s" (toYaml (omit $sc "enabled")) -}}
  {{- end -}}
{{- end -}}

{{/* Ingress */}}
{{- define "pkg.components.ingress.host" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- with $components.exposure.ingress.host -}}
    {{- printf "%s" (include "pkg.utils.template" (dict "tpl" . "ctx" $)) -}}
  {{- end -}}
{{- end -}}


{{- define "pkg.components.certificates.issuer" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- with $components.exposure.certificates.issuer }}
    {{- if .selfSigned }}
kind: Issuer
name: {{ include "vcluster.fullname" $ }}-self-signed
    {{- else }}
kind: {{ .kind }}
name: {{ .name }}
    {{- end }}
  {{- end }}
{{- end -}}


{{- define "pkg.components.certificates.secretTlsName" -}}
{{- $components := $.ctx.Values.global.components -}}
{{- default ( printf "%s-tls" ( include "pkg.cluster.name" $ ) ) $components.exposure.certificates.secretName -}}
{{- end -}}


{{/*
    Components Metrics enabled
*/}}
{{- define "pkg.components.metrics.enabled" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $metrics := $.metrics -}}
  {{- if $components.metrics -}}
    {{- $sc = $components.workloads.securityContext -}}
  {{- end -}}
  {{- if $sc.enabled -}}
    {{- printf "%s" (toYaml (omit $sc "enabled")) -}}
  {{- end -}}
{{- end -}}


{{/*
    Components Metrics enabled
*/}}
{{- define "pkg.components.serviceMonitor.enabled" -}}
  {{- $components := $.ctx.Values.global.components -}}
  {{- $metrics := $.metrics -}}
  {{- if $components.metrics -}}
    {{- $sc = $components.workloads.securityContext -}}
  {{- end -}}
  {{- if $sc.enabled -}}
    {{- printf "%s" (toYaml (omit $sc "enabled")) -}}
  {{- end -}}
{{- end -}}

