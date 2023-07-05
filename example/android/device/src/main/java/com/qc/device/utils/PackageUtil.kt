package com.qc.device.utils

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import com.qc.device.model.App

class PackageUtil(private val context: Context) {
    /**
     * 查询已安装应用列表
     */
    fun allPackages(): List<App> = try {
        val manager = context.packageManager
        val packages = try {
            manager.getInstalledPackages(0)
        } catch (_: Exception) {
            emptyList<PackageInfo>()
        }

        packages.map {
            val isSystem = (it.applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM) == 1
            App(
                appName = try {
                    it.applicationInfo.loadLabel(manager).toString()
                } catch (_: Exception) {
                    ""
                },
                packageName = it.packageName ?: "",
                version = it.versionName ?: "",
                versionCode = try {
                    it.versionCode
                } catch (_: Exception) {
                    0
                },
                isSystem = isSystem,
                createdAt = it.firstInstallTime,
                updatedAt = it.lastUpdateTime
            )
        }
    } catch (e: Exception) {
        e.printStackTrace()
        emptyList()
    }
}