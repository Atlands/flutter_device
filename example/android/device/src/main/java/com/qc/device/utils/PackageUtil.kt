package com.qc.device.utils

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import com.qc.device.model.App

class PackageUtil(private val context: Context) {
    /**
     * 查询已安装应用列表
     */
    fun allPackages(): List<App> {
        val manager = context.packageManager
        val packages = try {
            manager.getInstalledPackages(0)
        } catch (_: Exception) {
            emptyList<PackageInfo>()
        }

        return packages.map {
            val isSystem = (it.applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM) == 1
            App(
                name = try {
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
                isSystem = if (isSystem) 1 else 0,
                createdAt = it.firstInstallTime,
                updatedAt = it.lastUpdateTime
            )
        }
    }

    fun getPackageInfo(): App {
        val packageManager = context.packageManager
        val info = packageManager.getPackageInfo(context.packageName, 0)
        return App(
            name = try {
                context.applicationInfo.loadLabel(packageManager).toString()
            } catch (e: java.lang.Exception) {
                ""
            },
            packageName = info.packageName,
            version = info.versionName,
            versionCode = info.versionCode,
        )
    }
}